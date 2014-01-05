# encoding: utf-8

require 'files_common'

shared_examples_for 'an install method' do
  describe 'kafka archive' do
    let :kafka_archive do
      file(kafka_archive_path)
    end

    it 'exists' do
      expect(kafka_archive).to be_a_file
    end

    it 'has 644 permissions' do
      expect(kafka_archive).to be_mode 644
    end

    it 'matches md5 checksum' do
      expect(kafka_archive).to match_md5checksum kafka_archive_md5checksum
    end
  end

  describe 'extracted jar' do
    it_behaves_like 'a file in /opt/kafka' do
      let :path do
        jar_path
      end
    end
  end

  describe '/opt/kafka/libs' do
    it_behaves_like 'a directory in /opt/kafka' do
      let :path do
        '/opt/kafka/libs'
      end
    end
  end

  describe '/opt/kafka/bin' do
    let :path do
      '/opt/kafka/bin'
    end

    let :files do
      Dir[File.join(path, '*')]
    end

    it_behaves_like 'a directory in /opt/kafka'

    it 'contains kafka-run-class.sh' do
      expect(files.grep(/kafka-run-class\.sh$/)).to be_true
    end

    describe '/opt/kafka/bin/kafka-run-class.sh' do
      it_behaves_like 'an executable file in /opt/kafka' do
        let :path do
          '/opt/kafka/bin/kafka-run-class.sh'
        end
      end
    end
  end
end
