<script setup>
import { computed } from 'vue';
import { useMessageContext } from '../../provider.js';

import MessageFormatter from 'shared/helpers/MessageFormatter.js';
import { MESSAGE_VARIANTS } from '../../constants';
import { useAccount } from 'dashboard/composables/useAccount';
import UnpaidMessage from 'shared/components/UnpaidMessage.vue';

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
    <UnpaidMessage />
  </div>
</template>
