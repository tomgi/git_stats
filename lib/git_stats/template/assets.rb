class GitStats::Assets
  def self.prepare(out_path)
    FileUtils.cp_r('templates/assets', out_path)
  end
end