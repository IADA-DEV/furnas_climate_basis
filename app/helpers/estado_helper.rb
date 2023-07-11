module EstadoHelper
    def type_regiao
        if 'RS' == self.sg_estado.upcase
          dados = {estado: 'Rio Grande do Sul',		regiao: 'Sul'}
        elsif 'PR' == self.sg_estado.upcase
          dados = {estado: 'Paraná',		          regiao: 'Sul'}
        elsif 'SC' == self.sg_estado.upcase
          dados = {estado: 'Santa Catarina',		  regiao: 'Sul'}
        elsif 'AC' == self.sg_estado.upcase
          dados = {estado: 'Acre',		            regiao: 'Norte'}
        elsif 'AP' == self.sg_estado.upcase
          dados = {estado: 'Amapá',		            regiao: 'Norte'}
        elsif 'PA' == self.sg_estado.upcase
          dados = {estado: 'Pará',		            regiao: 'Norte'}
        elsif 'AM' == self.sg_estado.upcase
          dados = {estado: 'Amazonas',		        regiao: 'Norte'}
        elsif 'RO' == self.sg_estado.upcase
          dados = {estado: 'Rondônia',		        regiao: 'Norte'}
        elsif 'RR' == self.sg_estado.upcase
          dados = {estado: 'Roraima',		          regiao: 'Norte'}
        elsif 'TO' == self.sg_estado.upcase
          dados = {estado: 'Tocantins',		        regiao: 'Norte'}
        elsif 'MG' == self.sg_estado.upcase
          dados = {estado: 'Minas Gerais',		    regiao: 'Sudeste'}
        elsif 'ES' == self.sg_estado.upcase
          dados = {estado: 'Espírito Santo',		  regiao: 'Sudeste'}
        elsif 'RJ' == self.sg_estado.upcase
          dados = {estado: 'Rio de Janeiro',		  regiao: 'Sudeste'}
        elsif 'SP' == self.sg_estado.upcase
          dados = {estado: 'São Paulo',		        regiao: 'Sudeste'}
        elsif 'SE' == self.sg_estado.upcase
          dados = {estado: 'Sergipe',		          regiao: 'Nordeste'}
        elsif 'BA' == self.sg_estado.upcase
          dados = {estado: 'Bahia',		            regiao: 'Nordeste'}
        elsif 'AL' == self.sg_estado.upcase
          dados = {estado: 'Alagoas',		          regiao: 'Nordeste'}
        elsif 'CE' == self.sg_estado.upcase
          dados = {estado: 'Ceará',		            regiao: 'Nordeste'}
        elsif 'PE' == self.sg_estado.upcase
          dados = {estado: 'Pernambuco',		      regiao: 'Nordeste'}
        elsif 'PI' == self.sg_estado.upcase
          dados = {estado: 'Piauí',		            regiao: 'Nordeste'}
        elsif 'PB' == self.sg_estado.upcase
          dados = {estado: 'Paraíba',		          regiao: 'Nordeste'}
        elsif 'MA' == self.sg_estado.upcase
          dados = {estado: 'Maranhão',		        regiao: 'Nordeste'}
        elsif 'RN' == self.sg_estado.upcase
          dados = {estado: 'Rio Grande do Norte', regiao: 'Nordeste'}
        elsif 'DF' == self.sg_estado.upcase
          dados = {estado: 'Distrito Federal',    regiao: 'Centro-Oeste'}
        elsif 'MT' == self.sg_estado.upcase
          dados = {estado: 'Mato Grosso',		      regiao: 'Centro-Oeste'}
        elsif 'MS' == self.sg_estado.upcase
          dados = {estado: 'Mato Grosso do Sul',  regiao: 'Centro-Oeste'}
        elsif 'GO' == self.sg_estado.upcase
          dados = {estado: 'Goiás',		            regiao: 'Centro-Oeste'}
        end
    
        self.nme_estado = dados[:estado]
        self.cdg_regiao = dados[:regiao]
    end
end