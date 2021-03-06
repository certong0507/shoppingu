'use strict';
    
module.exports = function (sequelize, DataTypes) {

  var inbox = sequelize.define('inboxes', {
      id: {
          type: DataTypes.UUID,
          defaultValue: DataTypes.UUIDV4,
          primaryKey: true
      },
      user_1: {
          type: DataTypes.STRING(30),
          allowNull: false,
          field: 'user_1'
      },
      user_2: {
        type: DataTypes.STRING(30),
        allowNull: false,
        field: 'user_2'
      },
      offer_price: {
        type: DataTypes.DECIMAL(10, 3),
        field: 'offer_price'
      }
  }, {
      createdAt: 'createdAt',
      updatedAt: 'updatedAt',
      freezeTableName: true,
      underscored: true,
      associate: function (models) {
        inbox.belongsTo(models.post_travel_product);
      }
  });

  return inbox;
};