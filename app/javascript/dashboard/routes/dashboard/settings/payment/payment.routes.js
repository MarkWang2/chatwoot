import { frontendURL } from '../../../../helper/URLHelper';
import Index from './Index.vue';
import Plan from './components/Plan.vue';
import SettingsWrapper from '../SettingsWrapper.vue';

export default {
  routes: [
    {
      path: frontendURL('accounts/:accountId/settings/payment'),
      meta: {
        permissions: ['administrator'],
      },
      component: SettingsWrapper,
      children: [
        {
          path: '',
          name: 'payment_list',
          component: Index,
          meta: {
            permissions: ['administrator'],
          },
        },
      ],
    },
    {
      path: frontendURL('accounts/:accountId/plans/settings/payment'),
      meta: {
        permissions: ['administrator'],
      },
      component: SettingsWrapper,
      children: [
        {
          path: '',
          name: 'plan_list',
          component: Plan,
          meta: {
            permissions: ['administrator'],
          },
        },
      ],
    },
  ],
};
