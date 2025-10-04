# iOS IPA Dump

A lightweight tool for analyzing and decompiling iOS application packages (IPA files).

## Features

- **IPA Extraction**: Automatically extracts IPA contents
- **Objective-C Analysis**: Dumps Objective-C class headers using class-dump
- **Swift Analysis**: Extracts Swift classes in both mangled and demangled formats
- **Organized Output**: Creates structured directories for easy navigation

## Prerequisites

- `ipsw` tool installed and available in PATH
- `unzip` utility
  
## Installation

1. Clone or download the script
2. Make it executable:
   ```bash
   chmod +x ios-ipa_dump.sh
   ```

## Usage

```bash
./ios-ipa_dump.sh <path_to_ipa_file>
```

### Example

```bash
./ios-ipa_dump.sh /path/to/MyApp.ipa
```

## Output Structure

The tool creates the following directory structure:

```
output_directory/
├── app_name/              # Main analysis directory
│   ├── _extracted/        # Raw IPA contents
│   ├── class_dump/        # Objective-C class headers
│   └── swift_dump/        # Swift class analysis
│       ├── app_name-mangled.txt
│       └── app_name-demangled.txt
```

## Output Files

- **class_dump/**: Contains Objective-C header files
- **swift_dump/app_name-mangled.txt**: Swift classes with mangled names
- **swift_dump/app_name-demangled.txt**: Swift classes with readable names

## Troubleshooting

- Ensure `ipsw` is properly installed and accessible
- Verify the IPA file is not corrupted
