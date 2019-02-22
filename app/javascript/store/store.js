import 'babel-polyfill'
import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

Vue.use(Vuex)

const store = new Vuex.Store({
  strict: process.env.NODE_ENV !== 'production',
  state: {
    practiceRecodes: [],
    loading: false
  },
  mutations: {
    setPracticeRecodes (state, payload) {
      state.practiceRecodes = payload
    },
    setLoading (state, payload) {
      state.loading = payload
    }
  },
  actions: {
    async getPracticeRecodes ({ commit }, { userId, from, to }) {
      commit('setLoading', true)
      await axios.get(`/api/users/${userId}/practice_recodes/?date[]=${from}&date[]=${to}`)
        .then((res) => {
          if (res.status === 200) {
            commit('setPracticeRecodes', res.data.practice_recodes)
          } else {
            commit('setPracticeRecodes', [])
          }
        })
        .catch((res) => {
          commit('setLoading', false)
          console.log(res)
          throw res
        })
      commit('setLoading', false)
    }
  }
})
export default store
