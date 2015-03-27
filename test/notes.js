var assert = require('assert');
var request = require('supertest');

var app = require('../app');
var Note = require('../note');

describe('Notes', function () {
  var noteJSON = {
    id: 0,
    name: 'Example Note',
    body: 'Hello, world!'
  };

  beforeEach(function () {
    Note.create(noteJSON);
  });

  afterEach(function () {
    Note.remove();
  });

  describe('GET /', function () {
    it('gets all notes', function (done) {
      request(app)
        .get('/')
        .expect(200, [noteJSON])
        .end(done);
    });
  });

  describe('POST /', function () {
    it('creates a note', function (done) {
      request(app)
        .post('/')
        .send({ name: 'New Note', body: 'This is a new note.' })
        .expect(201)
        .end(done);
    });
  });

  describe('GET /:id', function () {
    it('gets a note', function (done) {
      request(app)
        .get('/0')
        .expect(200, noteJSON)
        .end(done);
    });
  });

  describe('PUT /:id', function () {
    it('updates a note', function (done) {
      request(app)
        .put('/0')
        .send({ name: 'New Note', body: 'This is a new note.' })
        .expect(201)
        .end(done);
    });
  });

  describe('DELETE /:id', function () {
    it('deletes a note', function (done) {
      request(app)
        .delete('/0')
        .expect(204)
        .end(done);
    });
  });
});
