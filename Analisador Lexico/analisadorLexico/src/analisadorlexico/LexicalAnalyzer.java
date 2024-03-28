/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author pedro
 */
public class LexicalAnalyzer {

    private static final Map<String, String> TOKEN_NAMES = new HashMap<>();

    static {
        TOKEN_NAMES.put("programa", "programa _palavra_reservada T_PROGRAMA 1\n");
        TOKEN_NAMES.put("inicio", "inicio _palavra_reservada T_INICIO 2\n");
        TOKEN_NAMES.put("fim", "fim _palavra_reservada T_FIM 3\n");

        TOKEN_NAMES.put("se", "se _palavra_reservada T_SE 4\n");
        TOKEN_NAMES.put("entao", "entao _palavra_reservada T_ENTAO 5\n");
        TOKEN_NAMES.put("senao", "senao _palavra_reservada T_SENAO 6\n");
        TOKEN_NAMES.put("fimse", "fimse _palavra_reservada T_FIMSE 7\n");

        TOKEN_NAMES.put("enquanto", "enquanto _palavra_reservada T_ENQTO 8\n");
        TOKEN_NAMES.put("fimenquanto", "fimenquanto _palavra_reservada T_FIMENQTO 9\n");

        TOKEN_NAMES.put("leia", "leia _palavra_reservada T_LEIA 10\n");
        TOKEN_NAMES.put("escreva", "escreva _palavra_reservada T_ESCREVA 11\n");

        TOKEN_NAMES.put("faca", "faca _palavra_reservada T_FACA 12\n");

        TOKEN_NAMES.put("+", "+ _operador_aritmetico_soma T_MAIS 13\n");
        TOKEN_NAMES.put("-", "- _operador_aritmetico_soma T_MENOS 14\n");

        TOKEN_NAMES.put("*", "* _operador_aritmetico_soma T_VEZES 15\n");
        TOKEN_NAMES.put("/", "/ _operador_aritmetico_soma T_DIV 16\n");

        TOKEN_NAMES.put(">", "-> _operador_relacional_maior T_MAIOR 17\n");
        TOKEN_NAMES.put("<", "<- _operador_relacional_menor T_MENOR 18\n");
        TOKEN_NAMES.put("=", "= _operador_relacional_igual T_IGUAL 19\n");

        TOKEN_NAMES.put("e", "e _operador_logico_conjucao T_E 20\n");
        TOKEN_NAMES.put("ou", "ou _operador_logico_disjuncao T_OU 21\n");
        TOKEN_NAMES.put("nao", "nao _operador_logico_negacao T_NAO 22\n");

        TOKEN_NAMES.put("atrib", "_operador_de_atribuicao T_ATRIB 23\n");
        TOKEN_NAMES.put("(", "_simbolo_abre_parenteses T_ABRE 24\n");
        TOKEN_NAMES.put(")", "_simbolo_fecha_parenteses T_FECHA 25\n");

        TOKEN_NAMES.put("inteiro", "int _palavra_reservada T_INTEIRO 26\n");
        TOKEN_NAMES.put("logico", "logico _palavra_reservada T_LOGICO 27\n");
        TOKEN_NAMES.put("V", "_constante_logica_de_verdade T_V 28\n");
        TOKEN_NAMES.put("F", "_constante_logica_de_falsidade T_F 29\n");
    }

    private BufferedReader reader;
    private String currentLine;
    private String[] tokens;
    private int currentIndex;

    public LexicalAnalyzer(String filename) throws IOException {
        reader = new BufferedReader(new FileReader(filename));
        currentLine = reader.readLine();
        nextLine();
    }

    private void nextLine() throws IOException {
        if (currentLine != null) {
            tokens = currentLine.trim().split("\\s+");
            currentIndex = 0;
            currentLine = reader.readLine();
        }
    }

    public String nextToken() throws IOException {
        while (currentLine != null || currentIndex < tokens.length) {
            if (currentIndex >= tokens.length) {
                nextLine();
                continue;
            }
            String token = tokens[currentIndex++];
            if (TOKEN_NAMES.containsKey(token)) {
                return TOKEN_NAMES.get(token);
            } else if (token.matches("[a-zA-Z][a-zA-Z0-9]*")) {
                return "_identificador T_IDENTIF \n";
            } else if (token.matches("\\d+")) {
                return "_numero T_NUMERO \n";
            }
        }
        return null;
    }

    public static void main(String[] args) {
        try {
            LexicalAnalyzer lexicalAnalyzer = new LexicalAnalyzer("src/analisadorlexico/teste.simples");
            String token;
            while ((token = lexicalAnalyzer.nextToken()) != null) {
                System.out.println("Token: " + token);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
