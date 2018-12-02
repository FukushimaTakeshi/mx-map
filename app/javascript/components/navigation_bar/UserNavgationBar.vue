<template>
  <div class="columns">

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
  margin-bottom: 10px;
}
</style>
