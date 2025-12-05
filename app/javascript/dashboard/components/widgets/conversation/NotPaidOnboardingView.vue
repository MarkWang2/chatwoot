<script setup>
import { computed } from 'vue';
import { useI18n } from 'vue-i18n';
import { useStoreGetters } from 'dashboard/composables/store';

const getters = useStoreGetters();
const { t } = useI18n();
const globalConfig = computed(() => getters['globalConfig/get'].value);
const currentUser = computed(() => getters.getCurrentUser.value);

const greetingMessage = computed(() => {
  const hours = new Date().getHours();
  let translationKey;
  if (hours < 12) {
    translationKey = 'ONBOARDING.GREETING_MORNING';
  } else if (hours < 18) {
    translationKey = 'ONBOARDING.GREETING_AFTERNOON';
  } else {
    translationKey = 'ONBOARDING.GREETING_EVENING';
  }
  return t(translationKey, {
    name: currentUser.value.name,
    installationName: globalConfig.value.installationName,
  });
});
</script>

<template>
  <div
    class="min-h-screen lg:max-w-5xl max-w-4xl mx-auto grid grid-cols-2 grid-rows-[auto_1fr_1fr] auto-rows-min gap-4 p-8 w-full font-inter overflow-auto"
  >
    <div class="col-span-full self-start">
      <p
        class="text-xl font-semibold text-n-slate-12 font-interDisplay tracking-[0.3px]"
      >
        {{ greetingMessage }}
      </p>
      <p class="text-n-slate-11 max-w-2xl text-base">
        {{
          $t('ONBOARDING.DESCRIPTION', {
            installationName: globalConfig.installationName,
          })
        }}
      </p>
    </div>

    <span> Hey，欢迎来到 Reply Bot ！</span>

    <span> 对话链接，一秒激活</span>

    <span>
      感谢您的注册。请按照下面的步骤，立刻开始使用我们的平台为您的客户提供服务吧
      <span/></span>
  </div>
</template>
