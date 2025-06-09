import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.Scanner;

public class WifiScanner {

    // static String jdbcUrl = "jdbc:postgresql://10.27.70.235:5432/scanner_wifi";
    //static String jdbcUrl = "jdbc:postgresql://192.168.10.133:5432/scanner_wifi";

    static String jdbcUrl;
    static String ip;
    static String jdbc = "jdbc:postgresql://";
    static String dataBase = "/scanner_wifi";
    static String jdbcUser = "usuario";
    static String jdbcPass = "senha123";

    public static void main(String[] args) {

        Scanner scanner = new Scanner(System.in);

        System.out.println("Insira o IP (Ex: 127.0.0.1)");
        ip = scanner.nextLine();
        
        scanner.close();
        
        jdbcUrl = jdbc + ip + dataBase;

        while (true) {
            try {
                // carrega o driver JDBC (baixado anteriormente)
                Class.forName("org.postgresql.Driver");

                // executa o comando para varredura Wi-Fi (windows)
                Process process = Runtime.getRuntime().exec("netsh wlan show networks mode=bssid");
                BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
                Connection conn = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPass);

                String line;
                String ssid = "";
                String security = "";
                String bssid = "";
                int signal = 0;
                int channel = 0;

                while ((line = reader.readLine()) != null) {
                    line = line.trim();

                    if (line.startsWith("SSID") && line.contains(" : ")) {
                        ssid = line.split(" : ")[1].trim();

                    } else if (line.startsWith("Autenticação")) {
                        security = line.split(" : ")[1].trim();  // armazena a segurança antes de encontrar o BSSID

                    } else if (line.startsWith("BSSID")) {
                        bssid = line.split(" : ")[1].trim();

                    } else if (line.startsWith("Sinal")) {
                        signal = Integer.parseInt(line.split(" : ")[1].replace("%", "").trim());

                    } else if (line.startsWith("Canal")) {
                        channel = Integer.parseInt(line.split(" : ")[1].trim());

                        if (!ssid.isEmpty() && !bssid.isEmpty()) {
                            double frequency = channelToFrequency(channel);

                            PreparedStatement ps = conn.prepareStatement(
                                "INSERT INTO wifi_scan (ssid, mac_ap, quality_link, signal_level, channel, frequency, last_beacon_ms, beacon_interval, wifi_security) " +
                                "VALUES (?,?,?,?,?,?,?,?,?)"
                            );
                            ps.setString(1, ssid);
                            ps.setString(2, bssid);
                            ps.setInt(3, signal);
                            ps.setInt(4, signal);
                            ps.setInt(5, channel);
                            ps.setDouble(6, frequency);
                            ps.setInt(7, 0); // fictício
                            ps.setInt(8, 0); // fictício
                            ps.setString(9, security);
                            ps.executeUpdate();

                            System.out.println("Inserido: SSID=" + ssid + " BSSID=" + bssid + " Canal=" + channel + " Sinal=" + signal + "% Segurança=" + security);

                            // limpa apenas os dados do BSSID (não o SSID ou segurança, pois podem se repetir)
                            bssid = "";
                            signal = 0;
                            channel = 0;
                        }
                    }
                }

                conn.close();
                System.out.println("Varredura concluída em " + LocalDateTime.now());

                Thread.sleep(60000); // Espera 60 segundos antes da próxima varredura

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public static double channelToFrequency(int channel) {
        if (channel >= 1 && channel <= 14) {
            return 2.412 + (channel - 1) * 0.005; // Banda 2.4GHz
        } else if (channel >= 36 && channel <= 165) {
            return 5.17 + (channel - 34) * 0.005; // Aproximação para banda 5GHz
        } else {
            return 0.0; // Desconhecido
        }
    }
}
