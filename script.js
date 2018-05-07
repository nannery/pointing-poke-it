var data = {
  taskScores: [0.5, 1, 2, 3, 5, 8, 13, 20, 40, 100],
  roomID:     55
}
var vm = new Vue({
  el:      '#app',
  data:    data,
  methods: {
    logIt: (e) => {
      console.log('app element');
    }
  }
})
