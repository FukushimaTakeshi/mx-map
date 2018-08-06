<script>
import { Pie } from 'vue-chartjs'
import EventBus from '../../packs/users/form.js'

export default {
  extends: Pie,
  props: [
    'chartFullYearData'
  ],
  mounted: function() {
    EventBus.$on('open-pie-chart', this.open)
  },
  methods: {
    open: function(count, name) {
      this.renderChart({
        labels: name,
        datasets: [
          {
            label: '内訳',
            backgroundColor: [
               'rgba(255, 100, 130, 0.2)',
               'rgba(100, 130, 255, 0.2)',
               'rgba(130, 255, 100, 0.2)'
            ],
            data: count
          }
        ]
      }, {
        title: {
          display: true,
          text: '内訳'
        },
        legend: {
          display: true
        },
        responsive: true,
        maintainAspectRatio: false
      })
    }
  }
}
</script>
