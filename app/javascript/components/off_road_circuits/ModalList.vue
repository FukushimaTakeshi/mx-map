<template>
  <transition name="modal">
    <div v-show="isOpen" class="modal is-active">
      <div class="modal-background" @click.self="close()" />
      <div class="modal-card">
        <header class="modal-card-head">
          <p class="modal-card-title">コース一覧</p>
        </header>
        <section class="modal-card-body is-paddingless">
          <div class="columns is-mobile is-multiline is-centered">
            <Loading v-if="loading"></Loading>

            <article v-show="OffRoadCircuitList.length == 0 && !loading" class="message is-danger">
              <div class="message-body">
                ごめんね。
                <p>まだコースが登録されていません。</p>
              </div>
            </article>

            <div v-for="circuit in OffRoadCircuitList" v-show="!loading" class="column is-four-fifths post">
              <span class="media">
                <div class="media-left">
                  <p class="image is-32x32">
                    <img :src="circuit.photo_url || 'http://placehold.it/32/?text=no-image'" alt="Image">
                  </p>
                </div>
                <div class="media-content">
                  <a :href="offRoadCircuitsUrl(circuit.id)" data-turbolinks="false">
                    <h4>{{ circuit.name }}</h4>
                  </a>
                </div>
                <div class="medis-right">
                  <button v-if="!findFavoriteCourse(circuit.id)" @click="registerFavoriteCircuit(circuit.id)" class="button is-small is-primary">お気に入り</button>
                  <button v-else @click="deleteFavoriteCircuit(circuit.id)" class="button is-info is-small is-outlined">登録済み</button>
                </div>
              </span>
            </div>
          </div>
        </section>
        <footer class="modal-card-foot">
          <button class="button" @click.self="close()">閉じる</button>
        </footer>
      </div>
    </div>
  </transition>
</template>

<script>
import axios from 'axios'
import { csrfToken } from 'rails-ujs'
axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken()

import ModalEvent from '../../packs/router/index.js'
import Loading from '../load/LoadContent.vue'

export default {
  components: { Loading },
  props: ['userId'],
  data() {
    return {
      isOpen: false,
      loading: true,
      OffRoadCircuitList: [],
      favoriteCourseList: []
    }
  },
  mounted: function() {
    ModalEvent.$on('open-circuits-modal', this.open)
    this.findAllFavoriteCourse().then(result => {
      this.favoriteCourseList = result
    })
  },
  methods: {
    open: function(prefectureId) {
      this.isOpen = true
      this.findByCircuits(prefectureId).then(result => {
        this.OffRoadCircuitList = result
        this.loading = false
      })
    },
    close: function() {
      this.isOpen = false
    },
    findByCircuits: async function(prefectureId) {
      this.loading = true
      const res = await axios.get(`/api/off_road_circuits/?prefecture_id=${prefectureId}`)
      if (res.status !== 200) {
        process.exit()
      }
      return res.data.off_road_circuits
    },
    findAllFavoriteCourse: async function() {
      const res = await axios.get(`/api/users/${this.userId}/favorite_courses`)
      if (res.status !== 200) {
        process.exit()
      }
      return res.data.favorite_courses
    },
    findFavoriteCourse: function(circuitId) {
      const favoriteCircuit = this.favoriteCourseList.find((course) => {
        return (course.off_road_circuit_id === circuitId)
      })
      return favoriteCircuit
    },
    registerFavoriteCircuit: async function(circuitId) {
      const res = await axios.post(
        `/api/users/${this.userId}/favorite_courses`,
        { off_road_circuit_id: circuitId, user_id: this.userId }
      )
      if (res.status !== 201) {
        process.exit()
      }
      this.findAllFavoriteCourse().then(result => {
        this.favoriteCourseList = result
      })
    },
    deleteFavoriteCircuit: async function(circuitId) {
      const favoriteCircuit = this.findFavoriteCourse(circuitId)
      const res = await axios.delete(`/api/users/${this.userId}/favorite_courses/${favoriteCircuit.id}`)
      if (res.status !== 200) {
        process.exit()
      }
      this.favoriteCourseList = this.favoriteCourseList.filter(n => n.id !== favoriteCircuit.id)
    },
    offRoadCircuitsUrl: function(circuitId) {
      return `/off_road_circuits/${circuitId}/`
    }
  }
}
</script>
<style>
.modal-card-body {
  max-height: 300px;
}
div.post:first-of-type {
  margin: 0.5rem;
  padding-top: 2rem;
  border-bottom: 1px solid #E6EAEE;
}
div.post {
  margin: 0.5rem;
  padding-bottom: 0.5rem;
  border-bottom: 1px solid #E6EAEE;
}
div.post:last-child {
  padding-bottom: 0;
  border-bottom: none;
}
</style>
