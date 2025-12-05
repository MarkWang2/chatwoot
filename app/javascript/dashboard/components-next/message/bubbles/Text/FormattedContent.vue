<script setup>
import { computed } from 'vue';
import { useMessageContext } from '../../provider.js';

import MessageFormatter from 'shared/helpers/MessageFormatter.js';
import { MESSAGE_VARIANTS } from '../../constants';
import { useMapGetter } from 'dashboard/composables/store.js';

const props = defineProps({
  content: {
    type: String,
    required: true,
  },
  isOutgoing: { type: Boolean },
});

const { variant } = useMessageContext();

const paid = useMapGetter('getPaid');

const formattedContent = computed(() => {
  if (variant.value === MESSAGE_VARIANTS.ACTIVITY) {
    return props.content;
  }
  return new MessageFormatter(props.content).formattedMessage;
});
</script>

<template>
  <span v-dompurify-html="formattedContent" class="prose prose-bubble" />
  <div v-if="!paid && isOutgoing">Not paid</div>
</template>
