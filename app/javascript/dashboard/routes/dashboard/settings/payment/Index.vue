<script>
import { ref, onMounted } from 'vue';
import QRCode from 'qrcode';
import axios from 'axios';
import BuildInfo from './components/BuildInfo.vue';

export default {
  components: {
    BuildInfo,
  },
  setup() {
    const order = ref({
      subWallet: '',
      amount: 0,
      received: 0,
      paid: false,
    });
    const qrcodeCanvas = ref(null);
    const orderId = 'order123'; // 真实项目用动态订单ID

    // 创建订单
    const createOrder = async () => {
      const res = await axios.post('http://localhost:3000/create-order', {
        orderId,
        amount: 10,
      });
      order.value.subWallet = res.data.subWallet;
      order.value.amount = res.data.amount;

      QRCode.toCanvas(qrcodeCanvas.value, res.data.tronUrl, { width: 200 });
    };

    // 轮询订单状态
    const pollOrderStatus = async () => {
      const res = await axios.get(
        `http://localhost:3000/order-status/${orderId}`
      );
      order.value.paid = res.data.paid;
      order.value.received = res.data.received;

      if (!order.value.paid) {
        setTimeout(pollOrderStatus, 5000); // 每5秒查询一次
      }
    };

    const copyAddress = () => {
      navigator.clipboard.writeText(order.value.subWallet);
      alert('地址已复制');
    };

    onMounted(async () => {
      await createOrder();
      pollOrderStatus();
    });

    return { order, qrcodeCanvas, copyAddress };
  },
};
</script>

<template>
  <div>
    <p>请支付 USDT(TRC20)：{{ order.amount }} USDT</p>
    <canvas ref="qrcode" />
    <p>支付地址: {{ order.subWallet }}</p>
    <button @click="copyAddress">复制地址</button>
    <BuildInfo />

    <h3>支付状态</h3>
    <p>已收到：{{ order.received }} USDT</p>
    <p v-if="order.paid" style="color: green">支付完成 ✅</p>
    <p v-else style="color: red">等待支付 ⏳</p>
  </div>
</template>
