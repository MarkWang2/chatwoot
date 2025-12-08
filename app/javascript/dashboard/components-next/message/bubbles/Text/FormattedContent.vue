<script setup>
import { computed } from 'vue';
import { useMessageContext } from '../../provider.js';

import MessageFormatter from 'shared/helpers/MessageFormatter.js';
import { MESSAGE_VARIANTS } from '../../constants';
import { useAccount } from 'dashboard/composables/useAccount';

const props = defineProps({
  content: {
    type: String,
    required: true,
  },
  isOutgoing: { type: Boolean },
});

const { variant } = useMessageContext();
const { currentAccount } = useAccount();

const isUnpaidAccount = computed(() => {
  const account = currentAccount.value;
  return account.paid === false;
});

const formattedContent = computed(() => {
  if (variant.value === MESSAGE_VARIANTS.ACTIVITY) {
    return props.content;
  }
  return new MessageFormatter(props.content).formattedMessage;
});
</script>

<template>
  <span v-dompurify-html="formattedContent" class="prose prose-bubble" />
  <div v-if="isUnpaidAccount && isOutgoing" class="flex flex-col gap-1 text-sm">
    <span class="inline-flex items-center gap-1">
      <img
        src="/vite-dev/dashboard/assets/images/payment/attention.svg"
        class="w-4 h-4"
      />
      当前为免费试用，仅供参考
    </span>
    <span class="inline-flex items-center gap-1">
      <img
        src="/vite-dev/dashboard/assets/images/payment/pay.svg"
        class="w-4 h-4"
      />
      付费购买后消息自动移除
    </span>
  </div>
</template>
