import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.Files;
import java.io.IOException;
import java.util.Date;
import java.text.SimpleDateFormat;

public class ChangeLogUpdater {
    public static void main(String[] args) {
        try {
            String semVerString = args[0];
            String isoDateString = getISODateStringFrom(new Date());

            String changelogPath = "./CHANGELOG.md";
            Path path = Paths.get(changelogPath);

            String changelog = new String(Files.readAllBytes(path), "UTF-8");

            String newContent = getNewContentForCHANGELOG(semVerString, isoDateString);
            changelog = changelog.replace("[Unreleased]", newContent);

            Files.write(path, changelog.getBytes("UTF-8"));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static String getISODateStringFrom(Date aJSDate) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        return dateFormat.format(aJSDate);
    }

    private static String getNewContentForCHANGELOG(String aSemVerString, String anISODateString) {
        return "[Unreleased]\n\n## [" + aSemVerString + "] " + anISODateString;
    }
}