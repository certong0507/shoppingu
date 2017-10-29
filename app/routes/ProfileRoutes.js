'use strict';

/**
 * Module dependencies.
 */
var passport = require('passport');

module.exports = function (app) {
    // Profile Routes
    var profiles = require('../../app/controllers/ProfileControllers');

    app.route('/profile/:profileId')
    .get(profiles.show)
    .put(profiles.updateProfile, profiles.updateAddress);

    // Setting up the profile api
    app.post('/profile', profiles.create);

    app.param('profileId', profiles.getProfileId);


};