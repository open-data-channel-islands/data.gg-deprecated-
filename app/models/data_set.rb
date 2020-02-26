class  DataSet  <  ActiveRecord::Base
    belongs_to  :data_category
    belongs_to  :place

    def  get_data_updated
        mtime  =  Date.today
        if  !live?
            mtime  =  File.mtime("storage/#{ENV['place_code']}/#{filename}").to_date
        end
        mtime
    end

    def  get_data_updated_formatted
        get_data_updated.strftime("%d/%m/%Y")
    end
end
