module  HomeHelper
    def  type_to_bootstrap_alert_str(level)
        if  level  ==  0
            return  'success'
        elsif  level  ==  1
            return  'info'
        elsif  level  ==  2
            return  'warning'
        elsif  level  ==  3
            return  'danger'
        end
    end
end
