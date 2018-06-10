<template>
  <main id="app">
    <li> {{ plan_list }} </li>
  </main>
</template>

<script>
import Vue from 'vue'
import store from '../../packs/plans/store';

export default {
  data() {
    return {
      // Jsonのデータを格納
      plan_list: []
    };
  },
  created() {
    // Json取得
    store.get_ajax('', 'plan_list');
    // Json取得後に呼び出される
    store.$on('GET_AJAX_COMPLETE', () => {
      this.plan_list = store.get_data('plan_list');
    });
  }
};
</script>
