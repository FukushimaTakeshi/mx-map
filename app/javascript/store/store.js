import 'babel-polyfill'
import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

Vue.use(Vuex)

const store = new Vuex.Store({
  strict: process.env.NODE_ENV !== 'production',
  state: {
    practiceRecodes: []
  },
  mutations: {
    setPracticeRecodes (state, payload) {
      state.practiceRecodes = payload
    }
  },
  actions: {
    async getPracticeRecodes ({ commit }, { userId, from, to }) {
      const res = await axios.get(`/api/users/${userId}/practice_recodes/?date[]=${from}&date[]=${to}`)
      commit('setPracticeRecodes', res.data.practice_recodes)
    }
  }
})
export default store
