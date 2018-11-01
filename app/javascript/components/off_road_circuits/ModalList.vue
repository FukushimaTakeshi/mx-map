<template>
  <transition name="modal">
    <div v-show="isOpen" class="modal is-active">
      <div class="modal-background" @click.self="close()" />
      <div class="modal-card">
        <section class="modal-card-body">
          <div class="card events-card">
            <header class="card-header">
              <p class="card-header-title">コース一覧</p>
            </header>
            <div class="card-table">
              <div class="content">
                <Loading v-if="loading"></Loading>
                <table class="table is-fullwidth is-hoverable">
                  <tbody>

                    <article v-show="OffRoadCircuitList.length == 0 && !loading" class="message is-danger">
                      <div class="message-body">
                        ごめんね。
                        <p>まだコースが登録されていません。</p>
                      </div>
                    </article>

                    <tr v-for="circuit in OffRoadCircuitList" v-show="!loading">
                      <td width="5%">
                        <figure class="image is-32x32">
                          <img :src="circuit.photo_url || 'http://placehold.it/32/?text=no-image'" alt="Image">
                        </figure>
                      </td>
                      <td>
                        <a :href="offRoadCircuitsUrl(circuit.id)" data-turbolinks="false">{{ circuit.name }}</a>
                      </td>
                      <td>
                        <button @click="registerFavoriteCircuit(circuit.id)" class="button is-small is-primary" href="#">
                          お気に入り
                        </button>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </section>
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
      OffRoadCircuitList: []
    }
  },
  mounted: function() {
    ModalEvent.$on('open-circuits-modal', this.open)
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
    registerFavoriteCircuit: async function(circuitId) {
      const res = await axios.post(`/api/users/${this.userId}/favorite_courses/`, { off_road_circuit_id: circuitId })
      if (res.status !== 200) {
        process.exit()
      }
    },
    offRoadCircuitsUrl: function(circuitId) {
      return `/off_road_circuits/${circuitId}/`
    }
  }
}
</script>
