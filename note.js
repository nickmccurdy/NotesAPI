var mongoose = require('mongoose');
mongoose.connect('mongodb://localhost/notes');

module.exports = mongoose.model('Note', {
  name: String,
  body: String
});
