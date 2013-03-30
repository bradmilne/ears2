class AddAudiofilesToQuestion < ActiveRecord::Migration
  def change
  	add_column :questions, :audioclip_mp3_file_name,    :string
    add_column :questions, :audioclip_mp3_content_type, :string
    add_column :questions, :audioclip_mp3_file_size,    :integer
    add_column :questions, :audioclip_mp3_updated_at,   :datetime

    add_column :questions, :audioclip_wav_file_name,    :string
    add_column :questions, :audioclip_wav_content_type, :string
    add_column :questions, :audioclip_wav_file_size,    :integer
    add_column :questions, :audioclip_wav_updated_at,   :datetime
  end
end
