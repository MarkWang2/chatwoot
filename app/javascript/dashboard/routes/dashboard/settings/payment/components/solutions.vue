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
  <div class="flex justify-center space-x-4">
    <!-- Pro Plan -->
    <div class="bg-gray-900 p-6 rounded-xl w-80">
      <h2 class="text-xl font-bold">专业版 / Pro</h2>
      <p class="mt-2 text-lg">348 USD</p>
      <p class="text-sm text-gray-400 mt-2">每账户每年</p>
      <p class="text-sm mt-2">满是起步的小型团队和基础客户服务场景</p>
      <button class="bg-blue-600 py-2 px-4 rounded-full w-full mt-4">立即开始试用</button>
      <ul class="mt-4 space-y-2">
        <li>网页集成</li>
        <li>标准对话体检</li>
        <li>查询表单自动消息</li>
        <li>数据安全</li>
        <li>攻击防护系统</li>
      </ul>
    </div>

    <!-- Team Plan -->
    <div class="bg-gray-900 p-6 rounded-xl w-80">
      <h2 class="text-xl font-bold">团队版 / Team</h2>
      <p class="mt-2 text-lg">588 USD</p>
      <p class="text-sm text-gray-400 mt-2">每账户每年</p>
      <p class="text-sm mt-2">适合多数中小团队的客服场景</p>
      <button class="bg-blue-600 py-2 px-4 rounded-full w-full mt-4">立即开始试用</button>
      <ul class="mt-4 space-y-2">
        <li>多渠道接入</li>
        <li>一键生成聊天链接</li>
        <li>免费消息自动翻译</li>
        <li>高级自动化规则</li>
        <li>报表和统计</li>
        <li>攻击防护系统</li>
      </ul>
    </div>

    <!-- Enterprise Plan -->
    <div class="bg-gray-900 p-6 rounded-xl w-80">
      <h2 class="text-xl font-bold">企业版 / Enterprise</h2>
      <p class="mt-2 text-lg">1188 USD</p>
      <p class="text-sm text-gray-400 mt-2">每账户每年</p>
      <p class="text-sm mt-2">适合需要高质量客服和高级可订制的企业</p>
      <button class="bg-blue-600 py-2 px-4 rounded-full w-full mt-4">立即开始试用</button>
      <ul class="mt-4 space-y-2">
        <li>对话页自定义域名</li>
        <li>聊天机器人</li>
        <li>高级API开放</li>
        <li>可双向删除历史对话</li>
        <li>对话无限制开发制</li>
      </ul>
    </div>
  </div>
</template>
