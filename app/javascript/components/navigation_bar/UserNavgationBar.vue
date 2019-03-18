<template>
  <div class="columns">
    <nav class="navbar is-info is-fixed-bottom is-hidden-tablet has-text-centered">
      <div id="navbarBasicExample" class="navbar-menu is-active is-paddingless">
        <nav class="level is-mobile">
          <div class="level-item has-text-grey has-text-centered">
            <div>
              <p class="heading is-marginless">TOP</p>
              <p class="title">
                <router-link to="/" class="icon">
                  <i class="fas fa-2x fa-home"></i>
                </router-link>
              </p>
            </div>
          </div>
          <div class="level-item has-text-grey has-text-centered">
            <div>
              <p class="heading is-marginless">お気に入り</p>
              <p class="title">
                <router-link to="/list" class="icon">
                  <i class="far fa-2x fa-heart"></i>
                </router-link>
              </p>
            </div>
          </div>
        </nav>
      </div>
    </nav>

    <div class="column is-2 hero is-fullheight is-hidden-mobile has-text-left">
      <aside class="menu">
        <ul class="menu-list">
          <li>
            <router-link to="/" class="button is-info is-fullwidth">
              <span class="icon">
                <i class="fas fa-home"></i>
              </span>
              <span>マイページTOP</span>
            </router-link>
          </li>
          <li>
            <router-link to="/list" class="button is-info is-fullwidth">
              <span class="icon">
                <i class="fa fa-star"></i>
              </span>
              <span>お気に入り登録</span>
            </router-link>
          </li>
        </ul>
      </aside>
    </div>

    <router-view :user-id="this.userId" />
    <router-view name="list" :user-id="this.userId" />

  </div>
</template>

<script>
export default {
  props: ['userId']
}
</script>

<style>
li {
  margin-bottom: 10px !important;
}
</style>
