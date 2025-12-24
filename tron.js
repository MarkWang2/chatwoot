// server.js
const express = require('express');
const bodyParser = require('body-parser');
const { TronWeb } = require('tronweb');
const cron = require('node-cron');

const app = express();
app.use(bodyParser.json());

// ---------------- TRON 节点配置 ----------------
const tronConfig = {
  fullHost: 'https://api.trongrid.io',
  // 如果有API Key可以填
};

// TronWeb 实例（主链节点，不设置私钥）
const tronWeb = new TronWeb(tronConfig);

// TRC20 USDT 合约
const USDT_CONTRACT = 'TXLAQ63Xg1NAzckPwKHvzw7CSEmLMEqcdj';
const USDT_DECIMALS = 1_000_000;

// 主钱包（收款）
const MAIN_WALLET = 'T主钱包地址';
const MAIN_PRIVATE_KEY = '主钱包私钥';

// 模拟数据库保存订单和子钱包
const orders = {}; // { orderId: { subWallet, privateKey, amount, paid } }

// ---------------- 创建订单接口 ----------------
app.post('/create-order', async (req, res) => {
  try {
    const { orderId, amount } = req.body;
    if (!orderId || !amount)
      return res.status(400).send('缺少 orderId 或 amount');

    // 创建唯一子钱包
    const account = await tronWeb.createAccount();
    orders[orderId] = {
      subWallet: account.address.base58,
      privateKey: account.privateKey,
      amount,
      paid: false,
    };

    res.json({
      subWallet: account.address.base58,
      amount,
      tronUrl: `tron://transfer?to=${account.address.base58}&amount=${amount}`,
    });
  } catch (err) {
    console.error('创建订单失败:', err);
    res.status(500).send('服务器错误');
  }
});

// ---------------- 定时任务检查订单 ----------------
cron.schedule('* * * * *', async () => {
  console.log('检查订单入账...');
  try {
    const contract = await tronWeb.contract().at(USDT_CONTRACT);

    for (const [orderId, order] of Object.entries(orders)) {
      if (order.paid) continue;

      const balance = await contract.methods.balanceOf(order.subWallet).call();
      const balanceUsdt = Number(balance) / USDT_DECIMALS;

      if (balanceUsdt >= order.amount) {
        console.log(`订单 ${orderId} 已支付，开始归集到主钱包`);

        // 用子钱包私钥创建新的 TronWeb 实例执行归集
        const subTronWeb = new TronWeb({
          ...tronConfig,
          privateKey: order.privateKey,
        });

        await subTronWeb
          .contract()
          .at(USDT_CONTRACT)
          .then(contract =>
            contract.methods
              .transfer(MAIN_WALLET, Math.floor(balanceUsdt * USDT_DECIMALS))
              .send({ feeLimit: 1_000_000 })
          );

        order.paid = true;
        console.log(`订单 ${orderId} 已归集到主钱包`);
      }
    }
  } catch (err) {
    console.error('定时检查失败:', err);
  }
});

app.listen(3000, () => {
  console.log('TRC20 收款服务已启动，端口 3000');
});
