import { createApp } from 'vue';
import { createPinia } from 'pinia';

import { Quasar, Dialog, Notify } from 'quasar';

// Import icon libraries
import '@quasar/extras/roboto-font/roboto-font.css';
import '@quasar/extras/material-icons/material-icons.css';

// Import Quasar css
import 'quasar/src/css/index.sass';

import App from './App.vue';
import router from './router';


// application insights - 241030 수정
import { ApplicationInsights } from '@microsoft/applicationinsights-web';
const appInsights = new ApplicationInsights({
    config: {
        instrumentationKey: '02a052e7-48b4-408a-ad85-9dfcefed3b77', // 연결 문자열에서 Instrumentation Key만 사용
        enableAutoRouteTracking: true
    }
});
appInsights.loadAppInsights();
// --

// 테스트 용도의 더미 백엔드
// import { fakeBackend } from './helpers';
// fakeBackend();

const app = createApp(App);

app.use(createPinia());
app.use(router);
app.use(Quasar, {
  plugins: {
    Dialog,
    Notify
  } // import Quasar plugins and add here
  /*
  config: {
    brand: {
      // primary: '#e46262',
      // ... or all other brand colors
    },
    notify: {...}, // default set of options for Notify Quasar plugin
    loading: {...}, // default set of options for Loading Quasar plugin
    loadingBar: { ... }, // settings for LoadingBar Quasar plugin
    // ..and many more (check Installation card on each Quasar component/directive/plugin)
  }
  */
});

app.mount('#app');
