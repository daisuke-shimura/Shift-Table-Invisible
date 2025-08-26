document.addEventListener('DOMContentLoaded', function () {
  const container = document.getElementById('calendar-container');
  if (!container) return;
  const header = container.querySelector('.calendar-grid.header');
  const titleEl = document.getElementById('calendar-title');
  if (!header || !titleEl) return;

  let ticking = false;

  function findDateCellAt(x, y) {
    const el = document.elementFromPoint(x, y);
    return el ? (el.closest ? el.closest('.date') : findAncestor(el, 'date')) : null;
  }

  function updateTitle() {
    const rect = container.getBoundingClientRect();
    const y = rect.top + header.offsetHeight + 2; // ヘッダー直下の y
    // まずは右端近くをチェックし、見つからなければ左へスキャンして最初の .date を使う
    let dateCell = null;
    for (let offset = 10; offset <= rect.width; offset += 10) {
      const x = rect.left + rect.width - offset;
      dateCell = findDateCellAt(x, y);
      if (dateCell && dateCell.dataset && dateCell.dataset.month) break;
    }

    if (dateCell && dateCell.dataset && dateCell.dataset.month) {
      titleEl.textContent = dateCell.dataset.month + '月';
    }
    ticking = false;
  }

  function onScroll() {
    if (!ticking) {
      ticking = true;
      requestAnimationFrame(updateTitle);
    }
  }

  container.addEventListener('scroll', onScroll, { passive: true });
  // 初回セット
  updateTitle();

  function findAncestor(node, className) {
    while (node && node !== document) {
      if (node.classList && node.classList.contains(className)) return node;
      node = node.parentNode;
    }
    return null;
  }
});