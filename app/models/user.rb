# frozen_string_literal: true

class User < ApplicationRecord
  has_many :viewing_party_users
  has_many :viewing_parties, through: :viewing_party_users

  has_secure_password

  validates_presence_of :name, :email, :password_digest
  validates_uniqueness_of :email, case_sensitive: false

  enum role: %w[default admin]

  def find_viewing_party_user(viewing_party)
    ViewingPartyUser.find_by(user: self, viewing_party: viewing_party)
  end

  def name_and_email
    "#{name} (#{email})"
  end

  def all_other_users
    User.where.not(id: id)
  end
end
