<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Laporan Perkembangan Anak Didik</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            font-size: 12px;
        }

        .container {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
        }

        .header-depdiknas {
            text-align: center;
            margin-bottom: 20px;
        }


        .header {
            text-align: center;
            margin-bottom: 20px;
        }

        .logo {
            width: 80px;
            height: 80px;
            margin-bottom: 10px;
        }

        .title {
            font-size: 16px;
            font-weight: bold;
        }

        .info-table {
            width: 100%;
            margin-bottom: 20px;
        }

        .info-table td {
            padding: 5px;
        }

        .info-label {
            width: 30%;
            font-weight: bold;
        }

        .section-title {
            font-weight: bold;
            margin-top: 15px;
            margin-bottom: 10px;
            text-decoration: underline;
        }

        .keterangan-anak {
            margin-left: 20px;
            list-style-type: decimal;
        }

        .keterangan-anak li {
            margin-bottom: 5px;
        }

        .signature {
            margin-top: 30px;
            text-align: right;
        }

        .signature-image {
            width: 100px;
            height: auto;
            margin-bottom: 5px;
        }

        .signature-text {
            text-align: center;
        }
    </style>
</head>

<body>
    <div class="container">
        <div class="header">
            <img src="{{ asset('images/garuda_pancasila.png') }}" alt="Lambang Garuda Pancasila" class="logo">
            <div class="title">LAPORAN</div>
            <div class="title">PERKEMBANGAN ANAK DIDIK</div>
            <div class="title">TAMAN KANAK-KANAK</div>
        </div>

        <table class="info-table">
            <tr>
                <td class="info-label">Nama Anak Didik</td>
                <td>:</td>
                <td></td>
            </tr>
            <tr>
                <td class="info-label">Nomor Induk</td>
                <td>:</td>
                <td></td>
            </tr>
            <tr>
                <td class="info-label">Nama Sekolah</td>
                <td>:</td>
                <td></td>
            </tr>
            <tr>
                <td class="info-label">NPSN/NSM</td>
                <td>:</td>
                <td></td>
            </tr>
            <tr>
                <td class="info-label">Alamat</td>
                <td>:</td>
                <td></td>
            </tr>
            <tr>
                <td class="info-label">Desa/Kelurahan</td>
                <td>:</td>
                <td></td>
            </tr>
            <tr>
                <td class="info-label">Kecamatan</td>
                <td>:</td>
                <td></td>
            </tr>
            <tr>
                <td class="info-label">Kabupaten/Kota Madya</td>
                <td>:</td>
                <td></td>
            </tr>
            <tr>
                <td class="info-label">Provinsi</td>
                <td>:</td>
                <td></td>
            </tr>
        </table>
        <br><br>
        <div class="header-depdiknas">
            <div class="title">DEPARTEMEN PENDIDIKAN NASIONAL</div>
            <div class="title">REPUBLIK INDONESIA</div>
        </div>

        <div class="header" style="margin-top: 30px; margin-bottom: 10px;">
            <div class="subtitle" style="font-weight: bold; text-decoration: underline;">KETERANGAN DIRI ANAK DIDIK
            </div>
        </div>

        <ol class="keterangan-anak">
            <li>Nama Anak Didik :</li>
            <li>Nama Panggilan :</li>
            <li>Jenis Kelamin :</li>
            <li>Tempat, Tanggal Lahir : ,</li>
            <li>Agama :</li>
            <li>Anak ke : dari bersaudara</li>
            <li>Alamat Anak Didik :</li>
            <li>Diterima di sekolah ini :
                <ul>
                    <li>Di kelompok :</li>
                    <li>Pada tanggal :</li>
                </ul>
            </li>
            <li>Nama Orang Tua/Wali :
                <ul>
                    <li>Ayah :</li>
                    <li>Ibu :</li>
                    <li>Alamat orang tua :</li>
                </ul>
            </li>
            <li>Pekerjaan Orang Tua/Wali :
                <ul>
                    <li>Ayah :</li>
                    <li>Ibu :</li>
                </ul>
            </li>
            <li>Nomor Telepon Orang Tua/Wali :</li>
            <li>Alamat Wali :</li>
            <li>Pekerjaan Wali :</li>
        </ol>

        <div class="signature">
            <p>Balikpapan, {{ now()->format('d F Y') }}</p>
            <p>Kepala Sekolah,</p>
            <br><br><br>
            <div>(Nama Kepala Sekolah)</div>
        </div>
    </div>
</body>

</html>
