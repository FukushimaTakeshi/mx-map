<template>
  <transition name="modal">
    <div v-show="isOpen" class="modal is-active">
      <div class="modal-background" @click.self="close()"></div>
      <div class="modal-card">
        <header class="modal-card-head">
          <p class="mdi-18px has-text-link">
            <i class="fas fa-heart"></i>
            {{ plan }}人
          </p>
          <p class="modal-card-title">{{ date }}</p>
          <button @click.self="close()" class="delete" aria-label="close"></button>
        </header>
        <section class="modal-card-body">
          <div class="modal-body">
            <p v-for="user in users">
              <a v-if="user.id !== null" :href="'/users/' + user.id">{{ user.username }}</a>
              <a v-else>{{ user.username }}</a>
            </p>
          </div>
        </section>
        <footer class="modal-card-foot">
          <button class="button is-success" @click.self="createAttendance()">走りに行く！</button>
        </footer>
      </div>
    </div>
  </transition>
</template>

<script>
import axios from 'axios'
import { csrfToken } from 'rails-ujs'
axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken()

import ModalEvent from '../../packs/off_road_circuits/form.js'

export default {
  name: 'App',
  props: [
    'circuitId'
  ],
  data() {
    return {
      date: "",
      plan: 0,
      users: [],
      isOpen: false
    }
  },
  mounted: function() {
    ModalEvent.$on('open-modal', this.open)
  },
  methods: {
    open: function(date) {
      this.isOpen = true
      this.date = date
      getAttendance(this.circuitId, date).then(result => {
        this.plan = result.plans.length
        this.users = result.users
      })
    },
    close: function() {
      this.isOpen = false
    },
    createAttendance: async function() {
      const res = await axios.post(`/api/plans/`, {date: this.date, off_road_circuit_id: this.circuitId })
      if (res.status !== 200) {
        console.log("Error!!")
        process.exit()
      }
      getAttendance(this.circuitId, this.date).then(result => {
        this.plan = result.plans.length
        this.users = result.users
      })
    }
  }
}

async function getAttendance(circuitId, date) {
  const res = await axios.get(`/api/plans/?off_road_circuit_id=${circuitId}&date=${date}`)
  if (res.status !== 200) {
    console.log("Error!!")
    process.exit()
  }
  console.log(res.data)
  return res.data
}
</script>

<style lang="scss">
// .modal-mask {
//   position: fixed;
//   z-index: 9998;
//   top: 0;
//   left: 0;
//   width: 100%;
//   height: 100%;
//   background-color: rgba(0, 0, 0, .5);
//   display: table;
//   transition: opacity .3s ease;
// }
//
// .modal-wrapper {
//   display: table-cell;
//   vertical-align: middle;
// }
//
// .modal-container {
//   width: 300px;
//   margin: 0px auto;
//   padding: 20px 30px;
//   background-color: #fff;
//   border-radius: 2px;
//   box-shadow: 0 2px 8px rgba(0, 0, 0, .33);
//   transition: all .3s ease;
//   font-family: Helvetica, Arial, sans-serif;
// }
//
// .modal-header h3 {
//   margin-top: 0;
//   color: #42b983;
// }
//
// .modal-body {
//   margin: 20px 0;
// }
//
// .modal-default-button {
//   float: right;
// }
//
// /*
//  * The following styles are auto-applied to elements with
//  * transition="modal" when their visibility is toggled
//  * by Vue.js.
//  *
//  * You can easily play with the modal transition by editing
//  * these styles.
//  */
//
// .modal-enter {
//   opacity: 0;
// }
//
// .modal-leave-active {
//   opacity: 0;
// }
//
// .modal-enter .modal-container,
// .modal-leave-active .modal-container {
//   -webkit-transform: scale(1.1);
//   transform: scale(1.1);
// }
</style>
