<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Siswa extends CI_Controller
{
    public function index()
    {
        $this->load->view('v_presensi_siswa');
    }

    public function lakukan_presensi()
    {
        $imageData = $_POST['imageData'];
        $imageData = str_replace('data:image/png;base64,', '', $imageData);
        $imageData = base64_decode($imageData);
        $uniqid = uniqid();
        $filename = './assets/absen/captured_image_' . $uniqid . '.png';
        file_put_contents($filename, $imageData);

        $picture_name = 'captured_image_' . $uniqid . '.png';
        $curl = curl_init();

        curl_setopt_array($curl, array(
            CURLOPT_URL => 'http://localhost:4000/absen',
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => '',
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 0,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => 'POST',
            CURLOPT_POSTFIELDS => '{
                "image1":"' . $picture_name . '"
            }',
            CURLOPT_HTTPHEADER => array(
                'Content-Type: application/json'
            ),
        ));

        $response = curl_exec($curl);
        curl_close($curl);

        $response_arr = json_decode($response, true);
        if ($response_arr[0][0]['identity']) {
            $identity_image = $response_arr[0][0]['identity'];
            $identity_image = str_replace('assets/upload/siswa/', '', $identity_image);

            $this->db->where('foto', $identity_image);
            $siswa_info = $this->db->get('siswa')->row_array();

            if (empty($siswa_info)) {
                http_response_code(500);
                echo json_encode([
                    'status' => false,
                    'message' => 'Data tidak ditemukan',
                    'start_masuk' => null,
                    'end_masuk' => null,
                    'waktu_saat_ini' => null,
                ]);
                exit;
            }

            $this->db->where('id', $siswa_info['id_kelas']);
            $kelas_info = $this->db->get('kelas')->row_array();

            date_default_timezone_set('Asia/Jakarta');

            $waktu_saat_ini = time();

            $start_masuk = strtotime(date('Y-m-d') . ' ' . $kelas_info['jam_masuk']);
            $end_masuk = strtotime(date('Y-m-d') . ' ' . $kelas_info['jam_masuk'] . " +30 minutes");

            if ($waktu_saat_ini >= $start_masuk && $waktu_saat_ini <= $end_masuk) {
                $this->db->where('tanggal', date('Y-m-d'));
                $this->db->where('id_siswa', $siswa_info['id']);
                $absen_sebelumnya = $this->db->get('laporan')->row_array();
                http_response_code(200);

                if ($absen_sebelumnya) {
                    echo json_encode([
                        'status' => true,
                        'message' => 'Halo ' . $siswa_info['nama_lengkap'] . ' ' . $kelas_info['nama_kelas'] . '. Kamu sudah melakukan presensi sebelumnya',
                        'start_masuk' => $start_masuk,
                        'end_masuk' => $end_masuk,
                        'waktu_saat_ini' => $waktu_saat_ini,
                    ]);
                } else {
                    $this->db->insert('laporan', [
                        'id_siswa' => $siswa_info['id'],
                        'waktu_masuk' => date('Y-m-d H:i:s'),
                        'tanggal' => date('Y-m-d'),
                        'status' => 'Hadir',
                    ]);

                    echo json_encode([
                        'status' => true,
                        'message' => 'Halo ' . $siswa_info['nama_lengkap'] . ' ' . $kelas_info['nama_kelas'] . '. Presensi kamu sudah masuk terimakasih telah menghadiri kelas',
                        'start_masuk' => $start_masuk,
                        'end_masuk' => $end_masuk,
                        'waktu_saat_ini' => $waktu_saat_ini,
                    ]);
                }
                exit;
            } else {
                http_response_code(400);
                echo json_encode([
                    'status' => false,
                    'message' => 'Terlambat',
                    'start_masuk' => $start_masuk,
                    'end_masuk' => $end_masuk,
                    'waktu_saat_ini' => $waktu_saat_ini,
                ]);
                exit;
            }
        } else {
            http_response_code(500);
            echo json_encode([
                'status' => false,
                'message' => 'Data tidak ditemukan',
                'start_masuk' => null,
                'end_masuk' => null,
                'waktu_saat_ini' => null,
            ]);
            exit;
        }
    }
}
