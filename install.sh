#!/bin/zsh
# Устанавливает команду `macos` в ~/.local/bin и добавляет PATH в ~/.zshrc.
set -e

src_dir=${0:A:h}
bin_dir=$HOME/.local/bin
rc=$HOME/.zshrc

if [[ ! -f $src_dir/macos ]]; then
    print -u2 "Ошибка: не найден скрипт $src_dir/macos"
    exit 1
fi

chmod +x "$src_dir/macos"
mkdir -p "$bin_dir"
ln -sf "$src_dir/macos" "$bin_dir/macos"
print "✓ Симлинк: $bin_dir/macos -> $src_dir/macos"

if ! grep -qE '^[[:space:]]*export[[:space:]]+PATH=.*\.local/bin' "$rc" 2>/dev/null; then
    print >> "$rc"
    print '# Команды пользователя (macos fetch)' >> "$rc"
    print 'export PATH="$HOME/.local/bin:$PATH"' >> "$rc"
    print "✓ PATH добавлен в $rc"
else
    print "• PATH уже настроен в $rc"
fi

print
print 'Готово. Откройте новый терминал или выполните: source ~/.zshrc'
print 'Проверка:  macos'
