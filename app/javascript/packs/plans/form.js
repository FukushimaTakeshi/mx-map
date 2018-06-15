import 'babel-polyfill'
import Vue from 'vue/dist/vue.esm'
// import Vue from 'vue'
import Plan from '../../components/plans/plans.vue'
import axios from 'axios'
import { csrfToken } from 'rails-ujs'

axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken()

Vue.component('child-component', {
  template: '<p>{{ val }}</p>',
  props: ['val'] // 受け取る属性名を指定
})
Vue.component('test-component', {
  template: '<p>{{ userId }}</p>',
  props: ['userId'],

   // 受け取る属性名を指定
  computed: {
    testfunc: function() {
      for(let id of this.userId) {
        // const res = await axios.get(`/plans/${id}`)
        // if (res.status !== 200) {
        //   console.log("Error!!")
        //   process.exit();
        // }
        // this.plans.push({ attendance: res.data.plans.attendance })
        axios.get(`/plans/${id}`)
          .then(res => {
            this.userId = res.data.plans.attendance
          });
      }
    }
  }
})

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    props: ['userId'],
    el: '#map',
    data: {
      plans: [],
      output: [],
      // userId: 1111111111
    },
    // mounted: function() {
    //   this.output = this.plans
    // },
    // mounted: {
    //
    // },
    //
    methods: {
      getAttendance: function() {
        console.log(this.userId)
        console.log(this.val)
        // let id = 1
        for(let id of this.userId) {
          // const res = await axios.get(`/plans/${id}`)
          // if (res.status !== 200) {
          //   console.log("Error!!")
          //   process.exit();
          // }
          // this.plans.push({ attendance: res.data.plans.attendance })
          axios.get(`/plans/${id}`)
            .then(res => {
              this.plans.push({ attendance: res.data.plans.attendance })
            });
        }
      },
      putAttendance: function(id) {
        axios.put(`/plans/${id}`, { circuit_id: id })
          .then(res => {
            console.log(res.data)
            this.output.push({ attendance: res.data.plans.attendance })
          });
      }
    }
  })
  // console.log(app)
})
