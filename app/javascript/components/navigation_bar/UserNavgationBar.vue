<template>
  <div class="columns">
    <!-- <user-navgation-list></user-navgation-list> -->

    <aside class="column is-2 aside hero is-fullheight is-hidden-mobile">
      <div>
        <div class="compose has-text-centered">
          <a class="button is-danger is-block is-bold">
            <span class="compose">Compose</span>
          </a>
        </div>
        <div class="main">
          <router-link to="/" class="item active">
            <span class="icon">
              <i class="fa fa-inbox"></i>
            </span>
            <span class="name">Inbox</span>
          </router-link>
          
          <router-link to="/foo" class="item">
            <span class="icon">
              <i class="fa fa-star"></i>
            </span>
            <span class="name">Go to Foo</span>
          </router-link>
          
          <router-link to="/bar" class="item">
            <span class="icon">
              <i class="fa fa-envelope-o"></i>
            </span>
            <span class="name">Go to Bar</span>
          </router-link>

        </div>
      </div>
    </aside>
    
    <router-view :user-id="this.userId" />
    <router-view name="foo" />
    <router-view name="bar" />

  </div>
</template>

<script>
  import UserNavgationList from "./UserNavgationList.vue";

  export default {
    components: { UserNavgationList },
    props: [
      'userId'
    ],
    data() {
      return {
        agent: Object,
        meta: Object,
        isTopicsPath: false,
        isSmartPhone: false
      }
    }
  }
</script>
