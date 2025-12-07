<script setup>
import { computed } from 'vue';
import { ref, onMounted } from 'vue';
import QRCode from 'qrcode';
import { useAccount } from 'dashboard/composables/useAccount';
import Button from 'dashboard/components-next/button/Button.vue';

const { currentAccount } = useAccount();
const prewWidgetUrl = computed(() => {
  const account = currentAccount.value;
  return (
    'localhost:3000/preview_web_widget?website_token=' +
    account.preview_websiteToken
  );
});
const qrCode = ref('');

onMounted(async () => {
  qrCode.value = await QRCode.toDataURL(prewWidgetUrl.value);
});
</script>

<template>
  <div class="max-w-4xl mx-auto p-6 bg-white shadow-lg rounded-lg mt-10">
    <!-- Header -->
    <div class="text-center">
      <h1 class="text-2xl font-semibold text-gray-800 mb-4">
        Hey, 欢迎来到 Reply Bot！
      </h1>
      <p class="text-gray-600">
        感谢您的注册。请按下面的步骤，立刻开始使用我们的平台为您的客户提供服务吧。
      </p>
    </div>

    <!-- Direct link section -->
    <div class="mt-6">
      <h2 class="text-xl font-semibold text-gray-800 mb-2">
        对话链接，一秒激活
      </h2>
      <p class="text-gray-600 mb-4">
        使用对话链接，可以让客户在互联网上任何地方直接联系您。
      </p>
      <div class="flex flex-col items-center">
        <input
          type="text"
          value="https://*****.talkvv.com"
          class="p-2 border rounded-lg w-80 text-center mb-4"
        />
        <p class="text-gray-500">
          您的专属对话链接（注意：免费试用链接在微信中不可用，如需在微信中使用请升级付费版）
        </p>
      </div>
    </div>

    <!-- QR Code Section -->
    <div class="flex justify-center mt-6">
      <img :src="qrCode" alt="QR Code" class="w-40 h-40" />
    </div>

    <!-- Payment Options -->
    <div class="mt-6">
      <h3 class="text-xl font-semibold text-gray-800 mb-2">选择付费方案</h3>
      <p class="text-gray-600 mb-4">
        请选择一个合适的方案，并完成付款后，即可通过您的接入渠道服务客户。我们支持银行卡、支付宝和数字货币支付。
      </p>
      <router-link :to="{ name: 'payment_list' }">
        <Button
          class="text-blue-500 text-sm"
          :label="选择付费方案"
        />
      </router-link>
    </div>
  </div>
</template>
