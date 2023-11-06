import os.path as p

GLIBC_FLAGS = [
  "-isystem",
  "/nix/store/rfw51dqr3qn7b6fjy8hmx6f0x3hfwbx6-glibc-2.37-8-dev/include",
]

database = None

compilation_database_folder = p.abspath(p.dirname(__file__))

def Settings(**kwargs):
  import ycm_core

  global database
  if database is None and p.exists(compilation_database_folder):
    database = ycm_core.CompilationDatabase(compilation_database_folder)

  language = kwargs['language']

  if language == 'cfamily':
    filename = kwargs['filename']

    compilation_info = database.GetCompilationInfoForFile(filename)
    if not compilation_info.compiler_flags_:
      return {}

    return {
      'flags': list(compilation_info.compiler_flags_) + GLIBC_FLAGS,
      'include_paths_relative_to_dir': compilation_info.compiler_working_dir_,
    }

  return {}
