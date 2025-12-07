<template>
  <div class="max-w-7xl mx-auto px-6 py-12">
    <!-- Header Section -->
    <div class="flex justify-between items-center mb-12">
      <div>
        <h1 class="text-4xl font-semibold text-gray-900">团队版 / Team</h1>
        <p class="text-lg text-gray-600 mt-2">
          您可以根据您的需求和预算，找到最适合的选项。让我们帮助您提升客户服务效率，同时确保成本在掌控之中。
        </p>
      </div>
      <div>
        <h2 class="text-5xl font-extrabold text-blue-600">588 USD</h2>
        <p class="text-xl text-gray-600">每帐号每年</p>
      </div>
    </div>

    <!-- Features List -->
    <div class="bg-white p-8 rounded-lg shadow-md">
      <h3 class="text-xl font-semibold text-gray-800 mb-4">
        适合大多数小团队的客服场景
      </h3>
      <ul class="space-y-3 text-gray-700">
        <li class="flex items-center">
          <svg
            class="w-5 h-5 text-green-500 mr-2"
            xmlns="http://www.w3.org/2000/svg"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M5 13l4 4L19 7"
            />
          </svg>
          多渠道接入
        </li>
        <li class="flex items-center">
          <svg
            class="w-5 h-5 text-green-500 mr-2"
            xmlns="http://www.w3.org/2000/svg"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M5 13l4 4L19 7"
            />
          </svg>
          一键生成聊天链接
        </li>
        <li class="flex items-center">
          <svg
            class="w-5 h-5 text-green-500 mr-2"
            xmlns="http://www.w3.org/2000/svg"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M5 13l4 4L19 7"
            />
          </svg>
          免费消息自动翻译
        </li>
        <li class="flex items-center">
          <svg
            class="w-5 h-5 text-green-500 mr-2"
            xmlns="http://www.w3.org/2000/svg"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M5 13l4 4L19 7"
            />
          </svg>
          高级自动化规则
        </li>
        <li class="flex items-center">
          <svg
            class="w-5 h-5 text-green-500 mr-2"
            xmlns="http://www.w3.org/2000/svg"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M5 13l4 4L19 7"
            />
          </svg>
          报表和统计
        </li>
        <li class="flex items-center">
          <svg
            class="w-5 h-5 text-green-500 mr-2"
            xmlns="http://www.w3.org/2000/svg"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M5 13l4 4L19 7"
            />
          </svg>
          攻击防护系统
        </li>
      </ul>
    </div>

    <div class="mt-8 text-center">
      <router-link :to="{ name: 'payment_list' }">
        <a class="text-blue-500 text-sm">立即开始试用</a>
      </router-link>
      <!--      <a href="#" class="bg-blue-600 text-blue-500 text-lg font-semibold px-6 py-3 rounded-lg hover:bg-blue-700">立即开始试用</a>-->
    </div>
  </div>
</template>
