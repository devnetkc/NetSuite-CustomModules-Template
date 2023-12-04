/** @format */
document.addEventListener('DOMContentLoaded', () => {
  const Titles = document.querySelectorAll('.sidebar-section-title'); //?

  const AccordionSidebar = event => {
    const TargetId = event.currentTarget.getAttribute('id'); //?
    for (const Title of Titles) {
      const TitleId = Title.getAttribute('id'); //?
      if (TargetId == TitleId) continue;
      Title.setAttribute('data-isopen', false);
    }
  };
  Titles.forEach(title => {
    title.addEventListener('click', event => {
      AccordionSidebar(event);
    });
  });
});
