<script>
export default {
  name: 'PaymentForm',
  data() {
    return {
      // State for the input field
      accountQuantity: 1,
      // State for the selected plan's ID
      selectedPlanId: 'team',
      // Data model for plans (extensible for more options)
      plans: [
        {
          id: 'team',
          name: 'Team',
          price: '588 USD每年',
          recommended: true,
        },
      ],
    };
  },
  mounted() {
    this.paidPlan = window.chatwootConfig?.paidPlan;
    this.plans = this.plans.map(plan => ({
      ...plan,
      price: `${this.paidPlan} USD每年`,
    }));
  },
  methods: {
    selectPlan(id) {
      this.selectedPlanId = id;
    },

    handlePayment() {
      this.$router.push({
        name: 'payment_list',
        accountId: { accountId: 'accountId' },
      });
    },
  },
};
</script>

<template>
  <div class="payment-container">
    <div class="page-header">
      <svg
        xmlns="http://www.w3.org/2000/svg"
        class="icon-wallet"
        viewBox="0 0 20 20"
        fill="currentColor"
      >
        <path
          fill-rule="evenodd"
          d="M6 2a1 1 0 00-1 1v1H4a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-1V3a1 1 0 00-1-1H6zm1 3h6V3H7v2zm6 3a1 1 0 11-2 0 1 1 0 012 0z"
          clip-rule="evenodd"
        />
      </svg>
      <h2>付款</h2>
    </div>

    <div class="content-card">
      <div class="form-section">
        <h3>请选择您的方案</h3>
        <p class="section-desc">
          所有方案均按年计费。如果您中途增加了账户，只需补上剩余期限的费用。我们接受数字货币
          (USDT) 支付
        </p>
      </div>

      <!--      <div class="form-section">-->
      <!--        <h3>请填写账号数量</h3>-->
      <!--        <div class="input-wrapper">-->
      <!--          <input type="number" v-model.number="accountQuantity" min="1" class="quantity-input">-->
      <!--        </div>-->
      <!--        <p class="help-text">请填写您要购买的账号数量，您的账户中最多可以添加的账号不超过这个数量。管理员账号和一般客服账号都会占用这个账号额度。</p>-->
      <!--      </div>-->

      <div class="form-section">
        <h3>请选择方案</h3>
        <div class="plan-selection">
          <div
            v-for="plan in plans"
            :key="plan.id"
            class="plan-card"
            :class="{ 'is-selected': selectedPlanId === plan.id }"
            @click="selectPlan(plan.id)"
          >
            <div class="plan-details">
              <div class="plan-header">
                <span class="plan-name">{{ plan.name }}</span>
                <span v-if="plan.recommended" class="badge">推荐</span>
              </div>
              <div class="plan-price">{{ plan.price }}</div>
            </div>
            <div v-if="selectedPlanId === plan.id" class="checkmark">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 20 20"
                fill="currentColor"
              >
                <path
                  fill-rule="evenodd"
                  d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                  clip-rule="evenodd"
                />
              </svg>
            </div>
          </div>
        </div>
      </div>

      <div class="form-footer">
        <p class="compare-link">
          你可以在这里查看详细的方案特性对比:

          <router-link
            :to="{ name: 'plan_list', prams: { accountId: accountId } }"
          >
            方案与价格页面。
          </router-link>
        </p>

        <button
          class="btn-pay text-white px-4 py-2 rounded-md bg-gradient-to-r from-[#0980FF] to-[#42B9FE]"
          @click="handlePayment"
        >
          去支付
        </button>

        <p class="security-note">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            class="icon-lock"
            viewBox="0 0 20 20"
            fill="currentColor"
          >
            <path
              fill-rule="evenodd"
              d="M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z"
              clip-rule="evenodd"
            />
          </svg>
          支付流程安全加密，使用数字货币 (USDT) 支付。我们只支持年付。
        </p>
      </div>
    </div>
  </div>
</template>

<style scoped>
/* Basic reset and font styles */
.payment-container {
  background-color: #f5f7fa;
  padding: 20px;
  min-height: 100vh;
  color: #333;
  width: 80%;
}

/* Header */
.page-header {
  display: flex;
  align-items: center;
  margin-bottom: 20px;
}

.icon-wallet {
  width: 24px;
  height: 24px;
  margin-right: 10px;
  color: #555;
}

.page-header h2 {
  margin: 0;
  font-size: 18px;
  font-weight: 500;
}

/* Main Content Card */
.content-card {
  background-color: #fff;
  padding: 30px;
  border-radius: 8px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  max-width: 600px;
  margin: 0 auto; /* Center the card */
}

/* Form Sections */
.form-section {
  margin-bottom: 30px;
}

.form-section h3 {
  font-size: 16px;
  font-weight: 500;
  margin-bottom: 10px;
  color: #333;
}

.section-desc,
.help-text,
.compare-link {
  font-size: 14px;
  color: #888;
  line-height: 1.5;
  margin-top: 5px;
}

/* Input Field */
.quantity-input {
  width: 100%;
  padding: 10px 12px;
  font-size: 16px;
  border: 1px solid #ddd;
  border-radius: 4px;
  box-sizing: border-box; /* Important for padding to not affect width */
  outline: none;
}
.quantity-input:focus {
  border-color: #409eff;
}

/* Plan Selection Card */
.plan-card {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px;
  border: 1px solid #ddd;
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.3s ease;
  position: relative;
}

/* Style for the selected state */
.plan-card.is-selected {
  border-color: #409eff;
  background-color: #ecf5ff;
}

.plan-details {
  display: flex;
  flex-direction: column;
}

.plan-header {
  display: flex;
  align-items: center;
  margin-bottom: 8px;
}

.plan-name {
  font-size: 18px;
  font-weight: 500;
  margin-right: 10px;
}

.badge {
  background-color: #e6f7ff;
  color: #409eff;
  font-size: 12px;
  padding: 2px 8px;
  border-radius: 10px;
}

.plan-price {
  color: #666;
  font-size: 14px;
}

.checkmark {
  color: #409eff;
  width: 24px;
  height: 24px;
}

/* Footer section */
.compare-link a {
  color: #409eff;
  text-decoration: none;
}

.btn-pay {
  width: 100%;
  padding: 12px;
  color: white;
  border: none;
  border-radius: 4px;
  font-size: 16px;
  font-weight: 500;
  cursor: pointer;
  margin-top: 20px;
  transition: background-color 0.2s;
}

.btn-pay:hover {
  background-color: #66b1ff;
}

.security-note {
  display: flex;
  align-items: center;
  justify-content: center;
  margin-top: 20px;
  font-size: 13px;
  color: #999;
}

.icon-lock {
  width: 16px;
  height: 16px;
  margin-right: 5px;
}
</style>
