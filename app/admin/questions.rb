ActiveAdmin.register Question do
   form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Question", :multipart => true do
      f.input :lesson_id, :as => :select, :collection => Lesson.all
      f.input :question
      f.input :answer
      f.input :octave
      f.input :audioclip_mp3
      f.input :audioclip_wav
    end

        
    
    # SUBMIT BUTTON BELOW
    f.buttons
end
end
