<script>
import { ref, onMounted } from 'vue';
import QRCode from 'qrcode';
import axios from 'axios';
import { useAccount } from 'dashboard/composables/useAccount';

export default {
  setup() {
    const order = ref({
      subWallet: '',
      amount: 0,
      received: 0,
      paid: false,
    });
    const qrcodeCanvas = ref(null);
    const orderId = 'order123'; // 真实项目用动态订单ID
    const { accountId } = useAccount();
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

    return { order, qrcodeCanvas, copyAddress, accountId };
  },
};
</script>

<template>
  <div class="max-w-4xl mx-auto bg-white shadow-lg rounded-lg p-6">
    <!-- Header -->
    <div class="flex items-center justify-between mb-6">
      <h1 class="text-2xl font-bold">等待付款</h1>
      <p class="text-gray-500">
        请通过下面的地址和金额完成付款，系统将自动确认和开通。
      </p>
    </div>

    <!-- Payment Details -->
    <div class="bg-gray-100 p-4 rounded-lg mb-6">
      <div class="flex justify-between mb-4">
        <div class="text-sm font-semibold text-gray-700">
          USDT 收款钱包地址 (TRC20)
        </div>
        <button class="text-blue-500 text-sm">查看二维码</button>
      </div>
      <div class="bg-white p-4 rounded-lg shadow-md">
        <input
          type="text"
          value="TMEoJbAxd7zNwXv3QYbJ1T2rFn7NWstBJ"
          readonly
          class="w-full bg-gray-200 p-2 rounded-md text-center text-gray-700 mb-4"
        />
        <div class="flex justify-between items-center">
          <button class="text-blue-500">复制地址</button>
          <div class="text-lg font-bold">转账金额</div>
          <input
            type="text"
            value="588"
            readonly
            class="bg-gray-200 p-2 rounded-md text-center text-gray-700"
          />
        </div>
      </div>
      <div class="mt-4 text-sm text-gray-600">
        <p>请仔细确认是否为 USDT 和 TRC20 网络。</p>
        <p>请仔细确认收款地址和转账金额，错误地址或金额负责自负。</p>
      </div>
    </div>

    <!-- Purchase Information -->
    <div class="bg-gray-100 p-4 rounded-lg">
      <h3 class="text-lg font-semibold mb-2">您的购买信息</h3>
      <div class="space-y-2">
        <p><strong>方案:</strong> Team</p>
        <p><strong>账户数:</strong> 1</p>
        <p><strong>价格:</strong> 588 USD</p>
      </div>
      <div class="mt-4 flex items-center">
        <router-link
          :to="{ name: 'plan_list', params: { accountId: accountId } }"
        >
          <button class="bg-red-600 text-white py-2 px-4 rounded-md text-sm">
            取消此订单
          </button>
        </router-link>

        <p class="ml-4 text-gray-500 text-sm">然后重新选择</p>
      </div>
    </div>
  </div>
</template>
