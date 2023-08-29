class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  has_one :syestem_config


  def config_system
    return syestem_config if syestem_config
    create_syestem_config
    return syestem_config
  end


  def create_system_config
    self.syestem_config.build.save
  end

  def status_menu
    return syestem_config.status_menu if syestem_config
    create_syestem_config
    return syestem_config.status_menu
  end

  def cdg_station
    return syestem_config.cdg_station if syestem_config
    create_syestem_config
    return syestem_config.cdg_station
  end

  def status_menu
    return syestem_config.status_menu if syestem_config
    create_syestem_config
    return syestem_config.status_menu
  end

end
