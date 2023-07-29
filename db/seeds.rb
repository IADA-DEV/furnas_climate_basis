# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# NoaWeatherStation.create(
#   'vl_altitude': 0,
#             'dta_inicio_operacao': '1981-07-01',
#             'dta_fim_operacao': '1999-12-31',
#             'vl_latitude': -0.73,
#             'name': 'CURUCA, BR',
#             'datacoverage': 0.7612,
#             'cdg_estacao': 'GHCND:BR000047003',
#             'elevationUnit': 'METERS',
#             'vl_longitude': -47.85
# )


User.create(name: 'Development', email: 'teste@dev.com', password: '231193!', password_confirmation: '231193!')

# obj_s = [
#     {
#         'CD_OSCAR': '0-2000-0-86715',
#         'DC_NOME': 'BRASILIA',
#         'FL_CAPITAL': 'N',
#         'DT_FIM_OPERACAO': nil,
#         'CD_SITUACAO': 'Operante',
#         'TP_ESTACAO': 'Automatica',
#         'VL_LATITUDE': '-15.78944444',
#         'CD_WSI': '0-76-0-5300108000000001',
#         'CD_DISTRITO': ' 10',
#         'VL_ALTITUDE': '1160.96',
#         'SG_ESTADO': 'DF',
#         'SG_ENTIDADE': 'INMET',
#         'CD_ESTACAO': 'A001',
#         'VL_LONGITUDE': '-47.92583332',
#         'DT_INICIO_OPERACAO': '2000-05-06T21:00:00.000-03:00'
#     }
# ]

# obj_s = obj_s.map(&:stringify_keys)

# obj_s.each do | attr| 
    
#     InmetWeatherStation.find_create_or_update(attr)
# end

# obj = [
#     {
#         'DC_NOME': 'BRASILIA',
#         'PRE_INS': '886.9',
#         'TEM_SEN': '15.4',
#         'VL_LATITUDE': '-15.78944444',
#         'PRE_MAX': '887',
#         'UF': 'DF',
#         'RAD_GLO': '-2.8',
#         'PTO_INS': '17.4',
#         'TEM_MIN': '18.7',
#         'VL_LONGITUDE': '-47.92583332',
#         'UMD_MIN': '90',
#         'PTO_MAX': '18',
#         'VEN_DIR': '216',
#         'DT_MEDICAO': '2022-11-01',
#         'CHUVA': '2.8',
#         'PRE_MIN': '886.4',
#         'UMD_MAX': '92',
#         'VEN_VEL': '3.7',
#         'PTO_MIN': '17.2',
#         'TEM_MAX': '19.5',
#         'TEN_BAT': '12.7',
#         'VEN_RAJ': '7',
#         'TEM_CPU': '21',
#         'TEM_INS': '18.7',
#         'UMD_INS': '92',
#         'CD_ESTACAO': 'A001',
#         'HR_MEDICAO': '0000'
#     },
#     {
#         'DC_NOME': 'BRASILIA',
#         'PRE_INS': '887',
#         'TEM_SEN': '16.9',
#         'VL_LATITUDE': '-15.78944444',
#         'PRE_MAX': '887',
#         'UF': 'DF',
#         'RAD_GLO': '-2.9',
#         'PTO_INS': '17.5',
#         'TEM_MIN': '18.7',
#         'VL_LONGITUDE': '-47.92583332',
#         'UMD_MIN': '91',
#         'PTO_MAX': '17.5',
#         'VEN_DIR': '227',
#         'DT_MEDICAO': '2022-11-01',
#         'CHUVA': '1.4',
#         'PRE_MIN': '886.9',
#         'UMD_MAX': '92',
#         'VEN_VEL': '3',
#         'PTO_MIN': '17.3',
#         'TEM_MAX': '19',
#         'TEN_BAT': '12.7',
#         'VEN_RAJ': '7',
#         'TEM_CPU': '21',
#         'TEM_INS': '18.9',
#         'UMD_INS': '91',
#         'CD_ESTACAO': 'A001',
#         'HR_MEDICAO': '0100'
#     },
#     {
#         'DC_NOME': 'BRASILIA',
#         'PRE_INS': '887',
#         'TEM_SEN': '18.6',
#         'VL_LATITUDE': '-15.78944444',
#         'PRE_MAX': '887.2',
#         'UF': 'DF',
#         'RAD_GLO': '-3.2',
#         'PTO_INS': '17.4',
#         'TEM_MIN': '18.8',
#         'VL_LONGITUDE': '-47.92583332',
#         'UMD_MIN': '91',
#         'PTO_MAX': '17.6',
#         'VEN_DIR': '201',
#         'DT_MEDICAO': '2022-11-01',
#         'CHUVA': '0.6',
#         'PRE_MIN': '886.9',
#         'UMD_MAX': '92',
#         'VEN_VEL': '2',
#         'PTO_MIN': '17.4',
#         'TEM_MAX': '18.9',
#         'TEN_BAT': '12.7',
#         'VEN_RAJ': '5.8',
#         'TEM_CPU': '20',
#         'TEM_INS': '18.8',
#         'UMD_INS': '91',
#         'CD_ESTACAO': 'A001',
#         'HR_MEDICAO': '0200'
#     }]


#     obj = obj.map(&:stringify_keys)

#     obj.each do | attr| 
#         InmetWeatherDatum.inport_create(attr)
#     end