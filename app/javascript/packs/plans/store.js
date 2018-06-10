import Vue from 'vue'
import axios from 'axios'

const URL_BASE = '/plans/1/';

export default new Vue({
  data: {
    plan_list: []
  },
  methods: {
    // Ajax通信でJsonを取得し、特定のプロパティに格納する
    // 取得したら GET_AJAX_COMPLETE で通知する
    get_ajax(url, name) {
      return axios.get(URL_BASE + url)
      .then((res) => {
        Vue.set(this, name, res.data);
        this.$emit('GET_AJAX_COMPLETE');
      });
    },
    // プロパティ名を指定してデータを取得
    get_data(name) {
      console.log(this.$data)
      return this.$data[name];
    }
  }
});
