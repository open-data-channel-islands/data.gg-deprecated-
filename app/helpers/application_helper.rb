module  ApplicationHelper
    def  action?(controller,  action)
        controller  ==  params[:controller]  &&  params[:action]  ==  action
    end

    def  storage_str(name)
        YAML.load(File.read("storage/#{ENV['place_code']}/strings.yml"))[name]
    end
end
