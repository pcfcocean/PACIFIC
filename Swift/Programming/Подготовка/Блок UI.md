#  UI Блок

[*] CALayer и UIView, в чем разница?
Ответ: CALayer нужен для отрисовки, а UIView преимущественно для взаимодействия с пользователем (тыки, свапы, драг&дроп)

[*] Жизненный цикл UIView
init
 willMove(toSuperview - UIView собирается быть добавленным к superview
  didMoveToSuperview - UIView было добавлено к superview
   didMoveToWindow - UIView было добавлено в window
    updateConstraints
     prepareForReuse - для ячеек
      layoutSubviews
       draw
      willMove(toSuperview - UIView собирается быть удаленным из superview
     didMoveToWindow - UIView было удалено из window
    didMoveToSuperview - UIView было удалено из его superview
   removeFromSuperview - UIView

[*] Жизненный цикл UIViewController, точный порядок всех методов
init
 loadView - если через код или awakeFromNib - если через сториборд
  viewDidLoad
   viewWillAppear
    viewIsAppearing
     viewWillLayoutSubviews
      viewDidLayoutSubviews
       viewDidAppear
      viewWillDisappear
     viewDidDisappear
    deinit


[*] Всегда ли вызывается loadView?
Ответ: Не всегда, если инит через сториБорд, то вместо loadView вызывается метод awakeFromNib.

[*] Какие есть способы верстки?
Ответ: АвторесайзМаски, фреймы, констреинты, SwiftUI

[*] Что такое frame?
[*] Что такое bounds?
[*] Когда меняется frame, когда меняется bounds?
[*] Когда ширина и высота frame будет не равна bounds?
Ответ: Если повернуть frame на какой-либо градус, тогда вычисление будет происходить по описанному вокруг frame прямоугольнику

[*] Как можно изменять размер вью сверстанной через frame?
Ответ: Авторесайз маски

[*] Что такое констреинты? - Система линейных уравнений

[*] В каком порядке решается эта система уравнений? - В зависимости от выставленного приоритета

[*] Что такое приоритет у констреинтов?
[*] 1 поинт констреинта это сколько? - Система конвертирует поинты в пиксели на этапе рендеринга. На разных девайсах с разными размерами Поинт может быть представлен 2 или 3 пикселями. Вычисление происходит по формуле: Поинт * Коэффициент увеличения плотности пикселей.

[*] Что такое Responder Chain?
Ответ: Респондер – это тот, кто отвечает на пользовательские жесты. Но как наша вью узнает, что пользователь нажал именно на нее и что ей нужно обработать этот экшн? Здесь нам на помощь приходит механизм Responder Chain. Когда пользователь нажимает на экран это событие попадает в наше приложение (объект UIApplication). Дальше оно отправляется в UIWindow, где и запускается цепочка поиска firstResponder’а, в границах которого и было произведено нажатие. Цепочка запускается рекурсивным вызовом метода hitTest по всей иерархии дочерних вью

[*] Что такое hitTest?
[*] У кого можно оверрайдить hitTest? - У наследников UIResponder

[*]  Как идет hitTest, сверху вниз или снизу вверх?
Ответ: Снизу вверх, проходя по цепочке респондеров и дергая hitTest и pointInside, до момента, пока не найдет того, кто может обработать нажатия, если такого нет, то нажатие будет проигнорировано

[*] Механизм target - action? - это механизм обработки различных ивентов у объектов UIResponder
[*] Как будет работать механизм, если поставить target nil? - обработка перейдет к следующему объекту по цепочке
[*] Как будет работать механизм, если поставить target self? - обработка будет сделана методом self из селетора
[*] Разница setNeedsLayout & layoutIfNeeded & layoutSubviews?
Ответ: 
setNeedsLayout - Метод setNeedsLayout для UIView сообщает системе, что вы хотите, чтобы она разметила и перерисовала это представление и все его подвиды, когда пришло время для цикла обновления. Это асинхронное действие, потому что метод завершается и возвращается немедленно, но только через некоторое время макет и перерисовка действительно происходят, и вы не знаете, когда будет этот цикл обновления.
layoutIfNeeded - это синхронный вызов, который сообщает системе, что вы хотите создать макет и перерисовать представление и его подвиды, и вы хотите, чтобы это было сделано немедленно, не дожидаясь цикла обновления, при этом важно вызвать метод setNeedsLayout ДО вызова layoutIfNeeded, иначе может ничего не произойти т.к. без setNeedsLayout система не знает о надобности перерисовки. Когда вызов этого метода завершен, макет уже скорректирован и нарисован на основе всех изменений, которые были отмечены до вызова метода.
layoutSubviews - “Насильная” перерисовка здесь и сейчас.

[*] Когда будет вызван layoutSubviews?
[*] Почему CollectionView и TableView даже имея 100500 элементов не фризят UI?
[*] Принцип работы reusableCells
[*] Можно ли добавить >1 контроллера на экран? 
[*] Как это сделать?
[*] Как перехватить момент перехода от дочернего контроллера к родительскому?
     Если дочернему был назначен didMove(toParent: self), то автоматически будет вызван метод didMove(toParent: ) у дочернего при его переходе к родительскому
 
[*] Может ли быть 2 объекта UIWindow на экране?
[*] Accessibility
