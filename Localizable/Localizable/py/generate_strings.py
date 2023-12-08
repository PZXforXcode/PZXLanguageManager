import csv

def generate_strings_file(csv_file_path, output_path_base):
    with open(csv_file_path, newline='', encoding='utf-8') as csvfile:
        reader = csv.reader(csvfile)
        header = next(reader)  # Get the header row

        # Map languages to column indices
        languages = {"English": header.index("English"), "Chinese": header.index("Chinese")}

        for language, language_column in languages.items():
            output_path = f"{output_path_base}_{language.lower()}.strings"
            with open(output_path, 'w', encoding='utf-8') as output_file:
                for row in reader:
                    key = row[0]
                    translation = row[language_column]
                    output_file.write(f'"{key}" = "{translation}";\n')
                csvfile.seek(0)  # Reset file pointer for the next language

if __name__ == "__main__":
    generate_strings_file("fanyiTest.csv", "Localizable")
