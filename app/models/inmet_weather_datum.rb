class InmetWeatherDatum < ApplicationRecord
    include Filterable
    
    validates :dta_medicao, uniqueness: { scope: [:hr_medicao, :inmet_weather_station_id],
                                        message: 'Registro já consta no sistema!' }

    belongs_to :inmet_weather_station, foreign_key: 'inmet_weather_station_id'

    scope :by_hr_medicao, ->(attrs) { where(hr_medicao: attrs) }
    scope :by_dta_medicao, ->(attrs) { where(dta_medicao: attrs) }
    scope :by_cdg_station, ->(attrs) { where(inmet_weather_station_id: attrs) }


    def self.inport_create(attrs)
        InmetWeatherDatum.create(
            chuva: attrs['CHUVA'],
            pre_ins: attrs['PRE_INS'],
            tem_sem: attrs['TEM_SEN'],
            pre_max: attrs['PRE_MAX'],
            rad_glo: attrs['RAD_GLO'],
            pto_ins: attrs['PTO_INS'],
            tem_min: attrs['TEM_MIN'],
            umd_min: attrs['UMD_MIN'],
            pto_max: attrs['PTO_MAX'],
            ven_dir: attrs['VEN_DIR'],
            pre_min: attrs['PRE_MIN'],
            umd_max: attrs['UMD_MAX'],
            ven_vel: attrs['VEN_VEL'],
            pto_min: attrs['PTO_MIN'],
            tem_max: attrs['TEM_MAX'],
            ven_raj: attrs['VEN_RAJ'],
            tem_ins: attrs['TEM_INS'],
            umd_ins: attrs['UMD_INS'],
            dta_medicao: attrs['DT_MEDICAO'],
            inmet_weather_station_id: attrs['CD_ESTACAO'],
            hr_medicao: self.set_hr_medicao(attrs['HR_MEDICAO'], attrs['DT_MEDICAO'])
        )
    end

    def self.inport_find_or_create(attrs)
        datum = InmetWeatherDatum.find_or_initialize_by(
            inmet_weather_station_id: attrs['CD_ESTACAO'],
            hr_medicao: self.set_hr_medicao(attrs['HR_MEDICAO'], attrs['DT_MEDICAO'])
        )
    
        datum.update(
            chuva: attrs['CHUVA'],
            pre_ins: attrs['PRE_INS'],
            tem_sem: attrs['TEM_SEN'],
            pre_max: attrs['PRE_MAX'],
            rad_glo: attrs['RAD_GLO'],
            pto_ins: attrs['PTO_INS'],
            tem_min: attrs['TEM_MIN'],
            umd_min: attrs['UMD_MIN'],
            pto_max: attrs['PTO_MAX'],
            ven_dir: attrs['VEN_DIR'],
            pre_min: attrs['PRE_MIN'],
            umd_max: attrs['UMD_MAX'],
            ven_vel: attrs['VEN_VEL'],
            pto_min: attrs['PTO_MIN'],
            tem_max: attrs['TEM_MAX'],
            ven_raj: attrs['VEN_RAJ'],
            tem_ins: attrs['TEM_INS'],
            umd_ins: attrs['UMD_INS'],
            dta_medicao: attrs['DT_MEDICAO']
        )
    end
    

    def self.set_hr_medicao(hr_min, data_str)
        date = Date.parse(data_str)
        hours = hr_min[0, 2].to_i
        minutes = hr_min[2, 2].to_i

        return Time.new(date.year, date.month, date.day, hours, minutes)
    end

end