import 'babel-polyfill'
import Vue from 'vue'
import Buefy from 'buefy'
// import 'buefy/dist/buefy.css'
Vue.use(Buefy)

import UserNavgationBar from '../../components/navigation_bar/UserNavgationBar.vue'
import UserStatusList from '../../components/users/UserStatusList.vue'

import Charts from '../../components/charts/Charts.vue'
import FavoriteList from '../../components/off_road_circuits/FavoriteList.vue'
import RegistrationForm from '../../components/practice_recodes/RegistrationForm.vue'
import HistoryList from '../../components/practice_recodes/HistoryList.vue'

import List from '../../components/off_road_circuits/List.vue'

import calender from '../../mixin/calendar.js'
Vue.mixin(calender)

import ja from 'vee-validate/dist/locale/ja.js'
import VeeValidate, { Validator } from 'vee-validate';
Vue.use(VeeValidate, { locale: ja })
Validator.localize('ja', ja)

import VueRouter from 'vue-router'
Vue.use(VueRouter)

import TurbolinksAdapter from 'vue-turbolinks'
Vue.use(TurbolinksAdapter)

import store from '../../store/store.js'

document.addEventListener('turbolinks:load', () => {
  if (document.getElementById('app')) {
    new Vue({
      store,
      data: {
        eventBus: new Vue()
      },
      router: new VueRouter({
        routes: [
          {
            path: '/',
            component: UserNavgationBar,
            children: [
              {
                path: '',
                component: UserStatusList,
                children: [
                  {
                    path: '',
                    components: {
                      'registration-form': RegistrationForm,
                      'charts': Charts,
                      'favorite-list': FavoriteList,
                      'history-list': HistoryList
                    }
                  }
                ]
              },
              {
                path: 'list',
                component: List
              }
            ]
          }
        ],
      }),
      // components: {UserNavgationBar}
    }).$mount('#app')
  }
});
