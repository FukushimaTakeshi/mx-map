import 'babel-polyfill'
import Vue from 'vue'

import UserNavgationBar from '../../components/navigation_bar/UserNavgationBar.vue'
import UserStatusList from '../../components/users/UserStatusList.vue'

import Charts from '../../components/charts/Charts.vue'
import FavoriteList from '../../components/off_road_circuits/FavoriteList.vue'
import List from '../../components/off_road_circuits/List.vue'

import ModalEvent from '../EventBus.js'
export default ModalEvent

import calender from '../../mixin/calendar.js'
Vue.mixin(calender)

import VueRouter from 'vue-router'

Vue.use(VueRouter)

import TurbolinksAdapter from 'vue-turbolinks'
Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  if (document.getElementById('app')) {
    new Vue({
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
                      'charts': Charts,
                      'favorite-list': FavoriteList
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
