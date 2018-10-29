import 'babel-polyfill'
import Vue from 'vue'

const Foo = { template: '<div>foo</div>' }
const Bar = { template: '<div>bar</div>' }

import UserNavgationBar from '../../components/navigation_bar/UserNavgationBar.vue'
import UserNavgationList from '../../components/navigation_bar/UserNavgationList.vue'

import UserStatusList from '../../components/users/UserStatusList.vue'

import Charts from '../../components/charts/Charts.vue'
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
            props: true,
            children: [
              {
                path: '',
                component: UserStatusList,
                props: true,
                children: [
                  {
                    path: '',
                    components: { 
                      charts: Charts,
                      list: List
                    }
                  }
                ]
              },
              { path: 'foo', component: Foo },
              { path: 'bar', component: Bar }
            ]
          }
        ],
      }),
      // components: {UserNavgationBar}
    }).$mount('#app')
  }
});
